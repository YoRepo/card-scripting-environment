--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔女术的小巷  (ID: 83289866)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的②③的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上的「魔女术」怪兽在1回合各有1次不会被战斗·效果破坏。
-- ②：自己场上的「魔女术」怪兽为让效果发动而把手卡丢弃的场合，可以作为代替把这张卡送去墓地。
-- ③：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡在自己的魔法与陷阱区域表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・バイストリート
function c83289866.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c83289866.target)
	e1:SetValue(c83289866.indct)
	c:RegisterEffect(e1)
	--ep set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83289866,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,83289866)
	e2:SetCondition(c83289866.setcon)
	e2:SetTarget(c83289866.settg)
	e2:SetOperation(c83289866.setop)
	c:RegisterEffect(e2)
	--change cost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(83289866)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,83289866)
	c:RegisterEffect(e3)
end
function c83289866.target(e,c)
	return c:IsSetCard(0x128)
end
function c83289866.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end
function c83289866.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c83289866.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c83289866.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c83289866.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c83289866.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
