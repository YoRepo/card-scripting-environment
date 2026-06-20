--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 神秘之妖精 艾尔菲莉娅  (ID: 85239662)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- ATK 1500 | DEF 900
--
-- Effect Text:
-- 1回合1次，把手卡1只风属性怪兽给对方观看才能发动。直到下次的对方的结束阶段时，双方玩家不能用持有给人观看的怪兽的等级以外的等级的怪兽为素材作超量召唤。
--[[ __CARD_HEADER_END__ ]]

--神秘の妖精 エルフィリア
function c85239662.initial_effect(c)
	--xyz limit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85239662,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c85239662.cost)
	e2:SetOperation(c85239662.operation)
	c:RegisterEffect(e2)
end
function c85239662.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsPublic()
end
function c85239662.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85239662.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c85239662.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.ShuffleHand(tp)
end
function c85239662.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c85239662.target)
	e1:SetLabel(e:GetLabel())
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
function c85239662.target(e,c)
	return not c:IsLevel(e:GetLabel()) and c:IsLevelAbove(1)
end
