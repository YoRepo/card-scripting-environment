--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 防霸龙 日球层龙  (ID: 51043053)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 4
-- ATK 0 | DEF 1900
--
-- Effect Text:
-- 对方手卡是4张以下而自己场上的怪兽只有这张卡的场合，对方不能攻击宣言。此外，1回合1次，自己场上有龙族·8星怪兽存在的场合才能发动。这张卡的等级直到结束阶段时变成8星。
--[[ __CARD_HEADER_END__ ]]

--防覇龍ヘリオスフィア
function c51043053.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c51043053.atcon)
	c:RegisterEffect(e1)
	--lv change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51043053,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c51043053.condition)
	e2:SetOperation(c51043053.operation)
	c:RegisterEffect(e2)
end
function c51043053.atcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)==1
		and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_HAND)<5
end
function c51043053.filter(c)
	return c:IsFaceup() and c:IsLevel(8) and c:IsRace(RACE_DRAGON)
end
function c51043053.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsLevel(8)
		and Duel.IsExistingMatchingCard(c51043053.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c51043053.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(8)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
