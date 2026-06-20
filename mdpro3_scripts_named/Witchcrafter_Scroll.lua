--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔女术的书卷  (ID: 19673561)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的②③的效果1回合只能有1次使用其中任意1个。
-- ①：1回合1次，自己的魔法师族怪兽战斗破坏怪兽时才能发动。自己从卡组抽1张。
-- ②：自己场上的「魔女术」怪兽为让效果发动而把手卡丢弃的场合，可以作为代替把这张卡送去墓地。
-- ③：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡在自己的魔法与陷阱区域表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・スクロール
function c19673561.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19673561,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c19673561.drcon)
	e1:SetTarget(c19673561.drtg)
	e1:SetOperation(c19673561.drop)
	c:RegisterEffect(e1)
	--ep set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19673561,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,19673561)
	e2:SetCondition(c19673561.setcon)
	e2:SetTarget(c19673561.settg)
	e2:SetOperation(c19673561.setop)
	c:RegisterEffect(e2)
	--change cost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(83289866)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,19673561)
	c:RegisterEffect(e3)
end
function c19673561.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	return rc:IsRelateToBattle() and rc:IsStatus(STATUS_OPPO_BATTLE)
		and rc:IsFaceup() and rc:IsRace(RACE_SPELLCASTER) and rc:IsControler(tp)
end
function c19673561.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c19673561.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c19673561.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c19673561.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c19673561.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c19673561.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c19673561.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
