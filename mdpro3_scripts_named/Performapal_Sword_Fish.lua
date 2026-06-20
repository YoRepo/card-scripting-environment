--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 娱乐伙伴 宝剑鱼  (ID: 15452043)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 2
-- ATK 600 | DEF 600
-- Setcode: 159
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功的场合发动。对方场上的全部怪兽的攻击力·守备力下降600。
-- ②：这张卡在怪兽区域存在，自己对怪兽的特殊召唤成功的场合发动。对方场上的全部怪兽的攻击力·守备力下降600。
--[[ __CARD_HEADER_END__ ]]

--EMソード・フィッシュ
function c15452043.initial_effect(c)
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15452043,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c15452043.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--addown
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15452043,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c15452043.condition)
	e3:SetOperation(c15452043.operation)
	c:RegisterEffect(e3)
end
function c15452043.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c15452043.condition(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c15452043.cfilter,1,nil,tp)
end
function c15452043.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
