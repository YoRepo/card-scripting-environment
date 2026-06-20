--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 白骨烤王  (ID: 6128460)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 1
-- ATK 300 | DEF 200
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在墓地存在当作「白骨」使用。
-- ②：自己场上的3星以下的不死族怪兽被战斗·效果破坏的场合，可以作为代替把手卡的这张卡丢弃。
-- ③：这张卡被送去墓地的场合才能发动。从卡组把以下怪兽合计2只加入手卡（同名卡最多1张）。那之后，选1张手卡丢弃。
-- ●「白骨」
-- ●「白骨烤王」以外的有「白骨」的卡名记述的怪兽
--[[ __CARD_HEADER_END__ ]]

--ワイトベイキング
function c6128460.initial_effect(c)
	--change code
	aux.EnableChangeCode(c,32274490,LOCATION_GRAVE)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_HAND)
	e2:SetTarget(c6128460.reptg)
	e2:SetValue(c6128460.repval)
	e2:SetOperation(c6128460.repop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_HANDES)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,6128460)
	e3:SetTarget(c6128460.thtg)
	e3:SetOperation(c6128460.thop)
	c:RegisterEffect(e3)
end
function c6128460.repfilter(c,tp)
	return c:IsFaceup() and c:IsLevelBelow(3) and c:IsRace(RACE_ZOMBIE) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c6128460.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and eg:IsExists(c6128460.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c6128460.repval(e,c)
	return c6128460.repfilter(c,e:GetHandlerPlayer())
end
function c6128460.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT+REASON_DISCARD)
end
function c6128460.thfilter(c)
	return aux.IsCodeOrListed(c,32274490) and not c:IsCode(6128460) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c6128460.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c6128460.thfilter,tp,LOCATION_DECK,0,nil)
		return g:GetClassCount(Card.GetCode)>=2
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c6128460.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c6128460.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetClassCount(Card.GetCode)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
	Duel.SendtoHand(tg1,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tg1)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
