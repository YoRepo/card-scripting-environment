--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 恐龙摔跤手·席拉腔骨龙  (ID: 75366958)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 2
-- ATK 100 | DEF 800
-- Setcode: 282
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤在决斗中只能有1次。
-- ①：自己场上没有怪兽存在的场合，这张卡可以从手卡特殊召唤。把这个方法特殊召唤的这张卡作为连接召唤的素材的场合，不是「恐龙摔跤手」怪兽的连接召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・コエロフィシラット
function c75366958.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,75366958+EFFECT_COUNT_CODE_OATH+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c75366958.spcon)
	e1:SetOperation(c75366958.spop)
	c:RegisterEffect(e1)
end
function c75366958.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c75366958.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c75366958.linklimit)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c75366958.linklimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x11a)
end
