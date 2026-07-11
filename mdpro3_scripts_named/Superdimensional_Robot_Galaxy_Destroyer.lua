--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Superdimensional Robot Galaxy Destroyer  (ID: 66523544)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank: 10
-- ATK 5000 | DEF 2000
-- Setcode: 0x7b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 10 monsters
-- Once per turn: You can detach 1 material from this card; destroy all Spells and Traps your opponent
-- controls.
-- Your opponent cannot activate Spell/Trap Cards in response to this effect's activation.
--[[ __CARD_HEADER_END__ ]]

--超次元ロボ ギャラクシー・デストロイヤー
function c66523544.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,3)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66523544,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c66523544.cost)
	e1:SetTarget(c66523544.target)
	e1:SetOperation(c66523544.operation)
	c:RegisterEffect(e1)
end
function c66523544.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66523544.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c66523544.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66523544.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c66523544.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c66523544.climit)
end
function c66523544.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c66523544.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c66523544.climit(e,lp,tp)
	return lp==tp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
