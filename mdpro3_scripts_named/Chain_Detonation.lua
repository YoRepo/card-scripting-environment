--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 连锁爆破  (ID: 51449743)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 给与对方基本分500分伤害。这张卡在连锁2或者连锁3发动的场合，这张卡加入卡组洗切。这张卡在连锁4以后发动的场合，这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--チェーン・ブラスト
function c51449743.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c51449743.damtg)
	e1:SetOperation(c51449743.damop)
	c:RegisterEffect(e1)
end
function c51449743.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c51449743.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
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
