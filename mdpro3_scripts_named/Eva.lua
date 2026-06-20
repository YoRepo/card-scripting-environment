--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 地外生命  (ID: 40177746)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 500 | DEF 200
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡被送去墓地的场合，把这张卡以外的自己的场上·墓地最多2只天使族·光属性怪兽除外才能发动。把除外数量的「地外生命」以外的2星以下的天使族·光属性怪兽从卡组加入手卡（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--イーバ
function c40177746.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40177746,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,40177746)
	e1:SetTarget(c40177746.thtg)
	e1:SetOperation(c40177746.thop)
	c:RegisterEffect(e1)
end
function c40177746.cfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemoveAsCost()
end
function c40177746.filter(c)
	return c:IsLevelBelow(2) and c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and not c:IsCode(40177746) and c:IsAbleToHand()
end
function c40177746.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40177746.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c40177746.filter,tp,LOCATION_DECK,0,1,nil) end
	local dg=Duel.GetMatchingGroup(c40177746.filter,tp,LOCATION_DECK,0,nil)
	local ct=math.min(2,dg:GetClassCount(Card.GetCode))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c40177746.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,ct,e:GetHandler())
	local rc=Duel.Remove(rg,POS_FACEUP,REASON_COST)
	e:SetLabel(rc)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,rc,tp,LOCATION_DECK)
end
function c40177746.thop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c40177746.filter,tp,LOCATION_DECK,0,nil)
	local ct=e:GetLabel()
	if dg:GetClassCount(Card.GetCode)<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=dg:SelectSubGroup(tp,aux.dncheck,false,ct,ct)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
