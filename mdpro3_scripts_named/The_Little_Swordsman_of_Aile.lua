--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: The Little Swordsman of Aile  (ID: 25109950)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 3
-- ATK 800 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Offer 1 monster on your side of the field as a Tribute to increase this monster's ATK by 700 points
-- until the end of the turn.
--[[ __CARD_HEADER_END__ ]]

--アイルの小剣士
function c25109950.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25109950,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c25109950.atkcost)
	e1:SetOperation(c25109950.atkop)
	c:RegisterEffect(e1)
end
function c25109950.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c25109950.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(700)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
