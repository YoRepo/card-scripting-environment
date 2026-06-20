--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 冲刺战士  (ID: 34257001)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 3
-- ATK 600 | DEF 1200
-- Setcode: 102
--
-- Effect Text:
-- 这张卡攻击的场合，伤害步骤内这张卡的攻击力上升1200。
--[[ __CARD_HEADER_END__ ]]

--ダッシュ・ウォリアー
function c34257001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c34257001.condtion)
	e1:SetValue(1200)
	c:RegisterEffect(e1)
end
function c34257001.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler()
end
