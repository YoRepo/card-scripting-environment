--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 剑斗兽 轻斗  (ID: 65984457)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 3
-- ATK 1400 | DEF 400
-- Setcode: 4121
--
-- Effect Text:
-- 这张卡用名字带有「剑斗兽」的怪兽的效果特殊召唤成功的场合，这张卡进行战斗的战斗阶段结束时可以让这张卡回到卡组并抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣トラケス
function c65984457.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65984457,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c65984457.spcon)
	e1:SetCost(c65984457.spcost)
	e1:SetTarget(c65984457.sptg)
	e1:SetOperation(c65984457.spop)
	c:RegisterEffect(e1)
end
function c65984457.spcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.gbspcon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():GetBattledGroupCount()>0
end
function c65984457.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c65984457.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c65984457.spop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
