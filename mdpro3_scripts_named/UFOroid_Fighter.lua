--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 飞碟机人战士  (ID: 32752319)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 10
-- ATK ? | DEF ?
-- Setcode: 22
--
-- Effect Text:
-- 「飞碟机人」＋战士族怪兽
-- 这只怪兽融合召唤只能用上记的卡进行。这张卡的原本的攻击力·守备力，变成融合素材的2只怪兽的原本的攻击力合计的数值。
--[[ __CARD_HEADER_END__ ]]

--ユーフォロイド・ファイター
function c32752319.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7602840,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,false,false)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c32752319.atkcon)
	e1:SetOperation(c32752319.atkop)
	c:RegisterEffect(e1)
end
function c32752319.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c32752319.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local catk=tc:GetBaseAttack()
		atk=atk+catk
		tc=g:GetNext()
	end
	if atk~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
