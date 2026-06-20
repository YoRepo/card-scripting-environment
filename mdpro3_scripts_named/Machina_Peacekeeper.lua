--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 机甲和平卫士  (ID: 78349103)
-- Type: Monster / Effect / Union
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 500 | DEF 400
-- Setcode: 54
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只机械族怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：场上的这张卡被破坏送去墓地时才能发动。从卡组把1只同盟怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・ピースキーパー
function c78349103.initial_effect(c)
	aux.EnableUnionAttribute(c,c78349103.filter)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(78349103,2))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c78349103.scon)
	e5:SetTarget(c78349103.stg)
	e5:SetOperation(c78349103.sop)
	c:RegisterEffect(e5)
end
c78349103.has_text_type=TYPE_UNION
function c78349103.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function c78349103.sfilter(c)
	return c:IsType(TYPE_UNION) and c:IsAbleToHand()
end
function c78349103.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c78349103.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c78349103.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c78349103.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c78349103.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
