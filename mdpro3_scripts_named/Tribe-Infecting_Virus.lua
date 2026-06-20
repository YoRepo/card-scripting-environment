--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 同族感染病毒  (ID: 33184167)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1600 | DEF 1000
--
-- Effect Text:
-- ①：丢弃1张手卡，宣言1个种族才能发动。场上的宣言种族的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--同族感染ウィルス
function c33184167.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33184167,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c33184167.cost)
	e1:SetTarget(c33184167.target)
	e1:SetOperation(c33184167.operation)
	c:RegisterEffect(e1)
end
function c33184167.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c33184167.filter(c)
	return c:IsFaceup()
end
function c33184167.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33184167.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c33184167.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	local race=0
	while tc do
		race=bit.bor(race,tc:GetRace())
		tc=g:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local arc=Duel.AnnounceRace(tp,1,race)
	e:SetLabel(arc)
	local dg=g:Filter(Card.IsRace,nil,arc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c33184167.filter2(c,rc)
	return c:IsFaceup() and c:IsRace(rc)
end
function c33184167.operation(e,tp,eg,ep,ev,re,r,rp)
	local arc=e:GetLabel()
	local g=Duel.GetMatchingGroup(c33184167.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,arc)
	Duel.Destroy(g,REASON_EFFECT)
end
