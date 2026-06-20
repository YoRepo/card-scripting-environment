--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 永火兽  (ID: 7264861)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 3
-- ATK 1600 | DEF 1200
-- Setcode: 11
--
-- Effect Text:
-- 自己手卡是0张的场合，得到以下效果。这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ビースト
function c7264861.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c7264861.aclimit)
	e1:SetCondition(c7264861.condition)
	c:RegisterEffect(e1)
end
function c7264861.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and Duel.GetAttacker()==e:GetHandler()
end
function c7264861.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
