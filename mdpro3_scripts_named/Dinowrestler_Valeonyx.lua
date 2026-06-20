--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 恐龙摔跤手·无限制重爪龙  (ID: 80831552)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 3
-- ATK 1600 | DEF 0
-- Setcode: 282
--
-- Effect Text:
-- ①：只有对方场上才有怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：只要自己场上有连接3以上的「恐龙摔跤手」怪兽存在，自己场上的表侧表示怪兽不受连接3以下的对方怪兽发动的效果影响。
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・バーリオニクス
function c80831552.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80831552.sprcon)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c80831552.immcon)
	e2:SetValue(c80831552.efilter)
	c:RegisterEffect(e2)
end
function c80831552.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c80831552.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11a) and c:IsLinkAbove(3)
end
function c80831552.immcon(e)
	return Duel.IsExistingMatchingCard(c80831552.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c80831552.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
		and re:IsActiveType(TYPE_MONSTER) and re:IsActivated() and re:GetHandler():IsLinkBelow(3)
end
