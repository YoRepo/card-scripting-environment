--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 无限起动 巨像山  (ID: 60195675)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank 7
-- ATK 2100 | DEF 3100
-- Setcode: 295
--
-- Effect Text:
-- 7星怪兽×2
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：把这张卡1个超量素材取除才能发动。这张卡的攻击力上升1000。
-- ②：这张卡战斗破坏对方怪兽时才能发动。那只怪兽在这张卡下面重叠作为超量素材。
-- ③：这张卡在墓地存在的场合，把自己场上1只机械族连接怪兽解放才能发动。这张卡守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--無限起動コロッサルマウンテン
function c60195675.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,7,2)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(60195675,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,60195675)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c60195675.atkcost)
	e1:SetOperation(c60195675.atkop)
	c:RegisterEffect(e1)
	--Attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60195675,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(c60195675.xyzcon)
	e2:SetTarget(c60195675.xyztg)
	e2:SetOperation(c60195675.xyzop)
	c:RegisterEffect(e2)
	--SpecialSummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60195675,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,60195676)
	e3:SetCost(c60195675.spcost)
	e3:SetTarget(c60195675.sptg)
	e3:SetOperation(c60195675.spop)
	c:RegisterEffect(e3)
end
function c60195675.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c60195675.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c60195675.xyzcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not c:IsRelateToBattle() then return false end
	e:SetLabelObject(tc)
	return tc and tc:IsType(TYPE_MONSTER) and tc:IsReason(REASON_BATTLE) and tc:IsCanOverlay()
		and (tc:IsLocation(LOCATION_GRAVE) or tc:IsFaceup() and tc:IsLocation(LOCATION_EXTRA+LOCATION_REMOVED))
end
function c60195675.xyztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end
function c60195675.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsCanOverlay() then
		Duel.Overlay(c,tc)
	end
end
function c60195675.cfilter(c,tp)
	return c:IsType(TYPE_LINK) and c:IsRace(RACE_MACHINE) and Duel.GetMZoneCount(tp,c)>0
end
function c60195675.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c60195675.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c60195675.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c60195675.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60195675.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
