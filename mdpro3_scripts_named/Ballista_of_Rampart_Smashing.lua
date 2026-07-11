--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Ballista of Rampart Smashing  (ID: 242146)
-- Type: Spell / Equip
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the equipped monster attacks a face-down Defense Position monster, it gains 1500 ATK during
-- damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--城壁壊しの大槍
function c242146.initial_effect(c)
	aux.AddEquipSpellEffect(c,true,true,Card.IsFaceup,nil)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c242146.atkcon)
	e2:SetValue(1500)
	c:RegisterEffect(e2)
end
function c242146.atkcon(e)
	if Duel.GetCurrentPhase()~=PHASE_DAMAGE_CAL then return false end
	local eqc=e:GetHandler():GetEquipTarget()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a==eqc and d:GetBattlePosition()==POS_FACEDOWN_DEFENSE
end
