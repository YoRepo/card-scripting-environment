--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 暗黑迅猛龙  (ID: 52319752)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 1800 | DEF 300
--
-- Effect Text:
-- 这张卡向对方怪兽攻击的场合，伤害步骤内攻击力上升400。这张卡被对方怪兽攻击的场合，伤害步骤内攻击力下降400。
--[[ __CARD_HEADER_END__ ]]

--暗黒ヴェロキ
function c52319752.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c52319752.condtion)
	e1:SetValue(c52319752.val)
	c:RegisterEffect(e1)
end
function c52319752.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end
function c52319752.val(e,c)
	if Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil then return 400
	elseif e:GetHandler()==Duel.GetAttackTarget() then return -400
	else return 0 end
end
