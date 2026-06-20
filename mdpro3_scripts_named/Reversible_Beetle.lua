--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 双面可逆甲虫  (ID: 45702357)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 1100 | DEF 1500
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合发动。这张卡以及和这张卡相同纵列的怪兽全部变成里侧守备表示。
-- ②：这张卡反转的场合发动。这张卡以及和这张卡相同纵列的表侧表示怪兽全部回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--リバーシブル・ビートル
function c45702357.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45702357,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,45702357)
	e1:SetTarget(c45702357.postg)
	e1:SetOperation(c45702357.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--flip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(45702357,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e3:SetCountLimit(1,45702358)
	e3:SetTarget(c45702357.tdtg)
	e3:SetOperation(c45702357.tdop)
	c:RegisterEffect(e3)
end
function c45702357.posfilter(c,g)
	return g:IsContains(c) and c:IsCanTurnSet()
end
function c45702357.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local cg=c:GetColumnGroup()
	cg:AddCard(c)
	local g=Duel.GetMatchingGroup(c45702357.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,cg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c45702357.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cg=c:GetColumnGroup()
	cg:AddCard(c)
	if c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c45702357.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,cg)
		if g:GetCount()>0 then
			Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
		end
	end
end
function c45702357.tdfilter(c,g)
	return c:IsFaceup() and g:IsContains(c) and c:IsAbleToDeck()
end
function c45702357.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local cg=c:GetColumnGroup()
	if not c:IsStatus(STATUS_BATTLE_DESTROYED) then cg:AddCard(c) end
	local g=Duel.GetMatchingGroup(c45702357.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,cg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c45702357.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cg=c:GetColumnGroup()
	if not c:IsStatus(STATUS_BATTLE_DESTROYED) then cg:AddCard(c) end
	if c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c45702357.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,cg)
		if g:GetCount()>0 then
			Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		end
	end
end
