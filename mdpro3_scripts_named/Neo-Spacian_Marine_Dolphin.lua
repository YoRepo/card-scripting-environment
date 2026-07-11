--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Neo-Spacian Marine Dolphin  (ID: 78734254)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level: 4
-- ATK 900 | DEF 1100
-- Setcode: 0x1f
-- Alias of: 17955766
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name is also treated as "Neo-Spacian Aqua Dolphin".
-- This card cannot be Special Summoned except with "NEX".
-- Once per turn, you can discard 1 card to look at your opponent's hand and select 1 Monster Card in
-- it.
-- If you control a monster with ATK greater than or equal to the selected monster's, destroy the
-- selected monster and inflict 500 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--N・マリン・ドルフィン
function c78734254.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78734254,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c78734254.cost)
	e2:SetTarget(c78734254.target)
	e2:SetOperation(c78734254.activate)
	c:RegisterEffect(e2)
	--add code
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_CODE)
	e4:SetValue(17955766)
	c:RegisterEffect(e4)
end
function c78734254.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c78734254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c78734254.filter(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk)
end
function c78734254.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(78734254,1))
		local tg=g:FilterSelect(tp,Card.IsType,1,1,nil,TYPE_MONSTER)
		local tc=tg:GetFirst()
		if tc then
			local atk=tc:GetAttack()
			if tc:IsAttackAbove(0) and Duel.IsExistingMatchingCard(c78734254.filter,tp,LOCATION_MZONE,0,1,nil,atk) then
				Duel.Destroy(tc,REASON_EFFECT)
				Duel.Damage(1-tp,500,REASON_EFFECT)
			end
		end
		Duel.ShuffleHand(1-tp)
	end
end
