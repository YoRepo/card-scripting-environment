--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 花札卫-松-  (ID: 81752019)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 230
--
-- Effect Text:
-- 「花札卫-松-」的①的效果1回合只能使用1次。
-- ①：这张卡召唤成功的场合发动。自己从卡组抽1张，给双方确认。那是「花札卫」怪兽以外的场合，那张卡送去墓地。
-- ②：这张卡被战斗或者对方的效果破坏送去墓地的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--花札衛－松－
function c81752019.initial_effect(c)
	--draw (summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,81752019)
	e1:SetTarget(c81752019.drtg1)
	e1:SetOperation(c81752019.drop1)
	c:RegisterEffect(e1)
	--draw (destroy)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c81752019.drcon2)
	e2:SetTarget(c81752019.drtg2)
	e2:SetOperation(c81752019.drop2)
	c:RegisterEffect(e2)
end
function c81752019.drtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c81752019.drop1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if not (tc:IsSetCard(0xe6) and tc:IsType(TYPE_MONSTER)) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
function c81752019.drcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE)
		or (rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp))
end
function c81752019.drtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c81752019.drop2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
