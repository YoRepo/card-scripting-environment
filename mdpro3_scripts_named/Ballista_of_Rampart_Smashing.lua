--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 破坏城壁的大枪  (ID: 242146)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 装备怪兽攻击里侧守备怪兽的场合，装备怪兽的攻击力上升1500。
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
