--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 恶龙  (ID: 54343893)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 5
-- ATK 2000 | DEF 2400
--
-- Effect Text:
-- ①：只有对方场上才有怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤的这张卡的原本的攻击力·守备力变成一半。
--[[ __CARD_HEADER_END__ ]]

--バイス・ドラゴン
function c54343893.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c54343893.spcon)
	e1:SetOperation(c54343893.spop)
	c:RegisterEffect(e1)
end
function c54343893.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c54343893.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(1200)
	e2:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e2)
end
