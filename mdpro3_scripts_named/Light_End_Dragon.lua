--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 光辉终结龙  (ID: 25132288)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2600 | DEF 2100
--
-- Effect Text:
-- 调整＋调整以外的光属性怪兽1只以上
-- 这张卡进行战斗的场合，怪兽的攻击宣言时才能发动。这张卡的攻击力·守备力下降500，和这张卡进行战斗的对方怪兽的攻击力·守备力直到结束阶段时下降1500。
--[[ __CARD_HEADER_END__ ]]

--ライトエンド・ドラゴン
function c25132288.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_LIGHT),1)
	c:EnableReviveLimit()
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25132288,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c25132288.condition)
	e1:SetTarget(c25132288.target)
	e1:SetOperation(c25132288.operation)
	c:RegisterEffect(e1)
end
function c25132288.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and c:GetAttack()>=500 and c:GetDefense()>=500 and tc:IsFaceup()
end
function c25132288.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetLabelObject():CreateEffectRelation(e)
end
function c25132288.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:GetAttack()>=500 and c:GetDefense()>=500 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(-500)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
		if tc:IsRelateToEffect(e) and tc:IsFaceup() and not c:IsHasEffect(EFFECT_REVERSE_UPDATE) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e3:SetCode(EFFECT_UPDATE_ATTACK)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetValue(-1500)
			tc:RegisterEffect(e3)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e4)
		end
	end
end
