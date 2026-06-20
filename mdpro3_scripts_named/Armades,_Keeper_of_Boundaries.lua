--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 幻层守护者 阿玛迪斯  (ID: 88033975)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fiend
-- Level 5
-- ATK 2300 | DEF 1500
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--幻層の守護者アルマデス
function c88033975.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	e1:SetCondition(c88033975.actcon)
	c:RegisterEffect(e1)
end
function c88033975.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
