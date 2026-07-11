--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Rhino  (ID: 66084673)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1700 | DEF 1400
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Fire Fist" monster you control attacks or is attacked, during damage calculation (in either
-- player's turn): You can send 1 face-up "Fire Formation" Spell/Trap Card you control and 1 "Fire
-- Fist" monster from your hand to the Graveyard once per battle; your attacking/attacked monster gains
-- ATK equal to the original ATK of the monster sent to the Graveyard, during damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--空炎星－サイチョウ
function c66084673.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66084673,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c66084673.atkcon)
	e1:SetCost(c66084673.atkcost)
	e1:SetOperation(c66084673.atkop)
	c:RegisterEffect(e1)
end
function c66084673.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttacker():IsControler(tp) and Duel.GetAttacker():IsSetCard(0x79))
		or (Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(tp) and Duel.GetAttackTarget():IsSetCard(0x79))
end
function c66084673.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsAbleToGraveAsCost()
end
function c66084673.filter2(c)
	return c:IsSetCard(0x79) and c:GetBaseAttack()>0 and c:IsAbleToGraveAsCost()
end
function c66084673.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(66084673)==0
		and Duel.IsExistingMatchingCard(c66084673.filter1,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(c66084673.filter2,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c66084673.filter1,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c66084673.filter2,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabel(g2:GetFirst():GetBaseAttack())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
	e:GetHandler():RegisterFlagEffect(66084673,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c66084673.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttacker()
	if c:IsControler(1-tp) then c=Duel.GetAttackTarget() end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(e:GetLabel())
	c:RegisterEffect(e1)
end
