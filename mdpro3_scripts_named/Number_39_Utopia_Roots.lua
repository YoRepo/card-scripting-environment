--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Number 39: Utopia Roots  (ID: 84124261)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank: 1
-- ATK 500 | DEF 100
-- Setcode: 0x48, 0x107f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 1 monsters
-- When any player's monster declares an attack: You can detach 1 Xyz Material from this card; negate
-- the attack, and if you negated an Xyz Monster's attack, this card gains ATK equal to that monster's
-- Rank x 500.
--[[ __CARD_HEADER_END__ ]]

--No.39 希望皇ホープ・ルーツ
function c84124261.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84124261,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c84124261.atkcost)
	e1:SetTarget(c84124261.atktg)
	e1:SetOperation(c84124261.atkop)
	c:RegisterEffect(e1)
end
aux.xyz_number[84124261]=39
function c84124261.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c84124261.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c84124261.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.NegateAttack() and tc:IsType(TYPE_XYZ) and tc:IsFaceup()
		and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetRank()*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
