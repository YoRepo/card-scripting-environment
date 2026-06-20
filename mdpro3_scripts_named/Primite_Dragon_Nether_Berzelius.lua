--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 原石龙 地下黄砷榴石龙  (ID: 26462013)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Dragon
-- Level 8
-- ATK 1600 | DEF 0
-- Setcode: 441
--
-- Effect Text:
-- 「原石」怪兽＋通常怪兽1只以上
-- ①：这张卡的攻击力上升作为这张卡的融合素材的通常怪兽数量×1000。
-- ②：只要这张卡在怪兽区域存在，等级·阶级·连接的数值是自己的场上·墓地的通常怪兽数量以下的对方场上的怪兽发动的效果无效化。
-- ③：这张卡从场上送去墓地的场合才能发动。从卡组把1只通常怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--原石竜ネザー・ベルセリウス
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddFusionProcFunFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1b9),aux.FilterBoolFunction(Card.IsFusionType,TYPE_NORMAL),1,127,true)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(s.matcheck)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.discon)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
	--special
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(s.spcon)
	e4:SetTarget(s.sptg)
	e4:SetOperation(s.spop)
	c:RegisterEffect(e4)
end
function s.matcheck(e,c)
	local ct=c:GetMaterial():Filter(Card.IsType,nil,TYPE_NORMAL):GetCount()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ct*1000)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function s.disfilter(c)
	return c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsDisabled()
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	local ct=Duel.GetMatchingGroupCount(aux.AND(Card.IsFaceupEx,Card.IsType),tp,LOCATION_GRAVE+LOCATION_MZONE,0,nil,TYPE_NORMAL)
	local p,loc,lv,rk=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_CONTROLER,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_LEVEL,CHAININFO_TRIGGERING_RANK)
	if not (re:IsActiveType(TYPE_MONSTER) and loc==LOCATION_MZONE and p==1-tp and not c:IsStatus(STATUS_BATTLE_DESTROYED)) then
		return false
	end
	if lv>0 then
		if ct>=lv then return true end
	elseif rk>0 then
		if ct>=rk then return true end
	elseif re:IsActiveType(TYPE_LINK) then
		if rc:IsLinkBelow(ct) then return true end
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	Duel.NegateEffect(ev)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function s.filter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
