--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 古代的采掘机  (ID: 67829249)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 7
--
-- Effect Text:
-- ①：自己场上有「古代的机械」怪兽存在的场合，丢弃1张手卡才能发动。从卡组选1张魔法卡在自己场上盖放。这个效果盖放的卡在这个回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--古代の採掘機
function c67829249.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SSET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c67829249.condition)
	e1:SetCost(c67829249.cost)
	e1:SetTarget(c67829249.target)
	e1:SetOperation(c67829249.operation)
	c:RegisterEffect(e1)
end
function c67829249.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x7)
end
function c67829249.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c67829249.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c67829249.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c67829249.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c67829249.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67829249.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c67829249.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c67829249.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
