--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 深渊蒸集队  (ID: 63941169)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 117
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己抽出自己场上的鱼族·海龙族·水族怪兽的种族种类的数量。这张卡的发动后，直到下次的自己回合的结束时自己不是水属性怪兽不能从额外卡组特殊召唤。
-- ②：这张卡在墓地存在的状态，自己场上的表侧表示的水属性怪兽被战斗·效果破坏的场合，把这张卡除外才能发动。自己的墓地·除外状态的1只「水精鳞」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--アビスチーム
local s,id,o=GetID()
function s.initial_effect(c)
	--same effect send this card to grave and spsummon another card check
	local e0=aux.AddThisCardInGraveAlreadyCheck(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.drtg)
	e1:SetOperation(s.drop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetLabelObject(e0)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.thcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_AQUA+RACE_FISH+RACE_SEASERPENT)
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if not Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil)
	local gc=g:GetClassCount(Card.GetRace)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,gc) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(gc)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,gc)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetTarget(s.splimit)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function s.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER) and c:IsLocation(LOCATION_EXTRA)
end
function s.cfilter2(c,tp,se)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
		and c:GetPreviousAttributeOnField()&ATTRIBUTE_WATER~=0
		and c:IsPreviousLocation(LOCATION_MZONE) and (se==nil or c:GetReasonEffect()~=se)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	local se=e:GetLabelObject():GetLabelObject()
	return eg:IsExists(s.cfilter2,1,e:GetHandler(),tp,se)
end
function s.thfilter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x74) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
