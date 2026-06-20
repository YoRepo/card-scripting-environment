--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 大薰风飞隼  (ID: 34109611)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1400 | DEF 1200
-- Setcode: 16
--
-- Effect Text:
-- 调整＋调整以外的名字带有「薰风」的怪兽1只以上
-- 这张卡同调召唤成功时，场上表侧表示存在的名字带有「薰风」的全部怪兽的攻击力上升600。
--[[ __CARD_HEADER_END__ ]]

--ダイガスタ・ファルコス
function c34109611.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x10),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34109611,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c34109611.condition)
	e1:SetOperation(c34109611.operation)
	c:RegisterEffect(e1)
end
function c34109611.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c34109611.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x10)
end
function c34109611.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c34109611.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(600)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
