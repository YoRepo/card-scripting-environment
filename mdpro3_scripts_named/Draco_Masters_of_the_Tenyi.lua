--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 天威之龙拳圣  (ID: 23935886)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Wyrm
-- ATK 2600 | LINK
-- Setcode: 300
--
-- Effect Text:
-- 包含连接怪兽的怪兽2只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡不会被和效果怪兽的战斗破坏。
-- ②：自己场上没有其他的效果怪兽存在的场合才能发动。选最多有自己墓地以及自己场上表侧表示存在的除效果怪兽以外的怪兽数量的对方场上的效果怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--天威の龍拳聖
function c23935886.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c23935886.lcheck)
	c:EnableReviveLimit()
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c23935886.indval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23935886,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,23935886)
	e2:SetCondition(c23935886.descon)
	e2:SetTarget(c23935886.destg)
	e2:SetOperation(c23935886.desop)
	c:RegisterEffect(e2)
end
function c23935886.lcheck(g,lc)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_LINK)
end
function c23935886.indval(e,c)
	return c:IsType(TYPE_EFFECT)
end
function c23935886.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c23935886.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c23935886.filter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c23935886.ctfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_EFFECT))
		or (c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and not c:IsType(TYPE_EFFECT))
end
function c23935886.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23935886.ctfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c23935886.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c23935886.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c23935886.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c23935886.ctfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c23935886.filter,tp,0,LOCATION_ONFIELD,1,ct,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
