--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 转晶之矿物协调者  (ID: 52119435)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Rock
-- ATK 1200 | LINK
--
-- Effect Text:
-- 效果怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：连接状态的这张卡以及这张卡所连接区的怪兽不会被对方的效果破坏。
-- ②：这张卡所连接区有怪兽2只存在的场合才能发动。那2只怪兽的控制权交换。
--[[ __CARD_HEADER_END__ ]]

--転晶のコーディネラル
function c52119435.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c52119435.indtg)
	e1:SetValue(aux.indoval)
	c:RegisterEffect(e1)
	--swap control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52119435,0))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,52119435)
	e2:SetTarget(c52119435.cttg)
	e2:SetOperation(c52119435.ctop)
	c:RegisterEffect(e2)
end
function c52119435.indtg(e,tc)
	local c=e:GetHandler()
	return c:IsLinkState() and tc==c or c:GetLinkedGroup():IsContains(tc)
end
function c52119435.ctfilter(c,tp)
	return c:IsControler(tp) and c:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c52119435.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetLinkedGroup()
	if chk==0 then return #g==2 and g:IsExists(c52119435.ctfilter,1,nil,tp) and g:IsExists(c52119435.ctfilter,1,nil,1-tp) end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,2,0,0)
end
function c52119435.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local a=g:GetFirst()
	local b=g:GetNext()
	if a and b then
		Duel.SwapControl(a,b)
	end
end
