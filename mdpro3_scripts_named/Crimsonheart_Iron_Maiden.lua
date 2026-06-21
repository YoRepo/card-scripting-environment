--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Iron Maiden  (ID: 211150)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Machine
-- Rank 8
-- ATK 0 | DEF 3000
-- Setcode: 0x95c (Crimsonheart)
--
-- Materials: 2 Level 8 monsters
--
-- Effect Text:
-- While you control "Barren Lady Lacrimosaica", you can also Xyz Summon this card using 1 monster
-- your opponent controls. You can only Special Summon "Crimsonheart Iron Maiden(s)" once per turn.
-- You can only use the (2) effect of "Crimsonheart Iron Maiden" once per turn.
-- (1) Your opponent's monsters must attack this card, if able.
-- (2) When your opponent activates a monster effect in the GY while this card is in your GY (Quick
-- Effect): You can banish this; negate the activation, and if you do, banish that card.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Iron Maiden
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	c:SetSPSummonOnce(id)
	c:EnableReviveLimit()
	--Xyz: 2 Level 8 monsters; or (controlling Lacrimosaica) overlay onto 1 opponent monster
	aux.AddXyzProcedure(c,nil,8,2,s.ovfilter,aux.Stringid(id,0))
	--(1) opponent's monsters must attack this card, if able
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e2:SetValue(s.atklimit)
	c:RegisterEffect(e2)
	--(2) (Quick Effect) from GY: when opponent activates a monster effect in the GY; banish this, negate & banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(s.discon)
	e3:SetCost(s.discost)
	e3:SetTarget(s.distg)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
end
--alternative Xyz material: overlay onto 1 opponent monster while controlling Lacrimosaica
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.ovfilter(c,e,tp)
	return c:IsControler(1-tp) and c:IsFaceup()
		and Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
end
--(1)
function s.atklimit(e,c)
	return c==e:GetHandler()
end
--(2)
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
		and loc&LOCATION_GRAVE~=0
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsAbleToRemove() then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
