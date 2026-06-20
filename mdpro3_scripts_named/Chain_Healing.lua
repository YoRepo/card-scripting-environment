--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 连锁治愈  (ID: 25050038)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己回复500基本分。这张卡在连锁2或者连锁3发动的场合，这张卡加入卡组洗切。这张卡在连锁4以后发动的场合，这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--チェーン・ヒーリング
function c25050038.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c25050038.rectg)
	e1:SetOperation(c25050038.recop)
	c:RegisterEffect(e1)
end
function c25050038.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c25050038.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=Duel.GetCurrentChain()
	if ct>3 then
		c:CancelToGrave()
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	elseif ct>1 then
		c:CancelToGrave()
		Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
