--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 宇迦御狐之御稻成  (ID: 49451215)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Beast
-- ATK 1500 | LINK
--
-- Effect Text:
-- 包含兽族怪兽的光属性怪兽2只
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡连接召唤的场合，以自己墓地1张速攻魔法卡为对象才能发动。那张卡在自己场上盖放。
-- ②：对方不能把场地区域的卡作为效果的对象。
-- ③：这张卡被破坏的场合才能发动。选最多有场地区域的卡数量的以下效果，那些效果适用（相同效果最多1个）。
-- ●对方场上1张卡破坏。
-- ●给与对方1500伤害。
--[[ __CARD_HEADER_END__ ]]

--うかのみつねのおなり
local s,id,o=GetID()
function s.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkAttribute,ATTRIBUTE_LIGHT),2,2,s.lcheck)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SSET)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.setcon)
	e1:SetTarget(s.settg)
	e1:SetOperation(s.setop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_FZONE,LOCATION_FZONE)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--destroy and damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
function s.lcheck(g,lc)
	return g:IsExists(Card.IsLinkRace,1,nil,RACE_BEAST)
end
function s.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function s.setfilter(c)
	return c:IsType(TYPE_QUICKPLAY) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.setfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,s.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToChain() and aux.NecroValleyFilter(tc) then
		Duel.SSet(tp,tc)
	end
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_FZONE,LOCATION_FZONE,nil)
	if chk==0 then return ct>0 end
	if not Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
	end
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_FZONE,LOCATION_FZONE,nil)
	if ct==0 then return end
	local b1=Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
	local op=0
	op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,1),1},
		{true,aux.Stringid(id,2),2},
		{b1 and ct==2,aux.Stringid(id,3),3})
	if op&1~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
		if #g>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
	if op&2~=0 then
		if op==3 then
			Duel.BreakEffect()
		end
		Duel.Damage(1-tp,1500,REASON_EFFECT)
	end
end
