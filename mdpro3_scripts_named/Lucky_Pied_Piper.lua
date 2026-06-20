--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 幸运之吹笛人  (ID: 68762510)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●这张卡战斗破坏对方怪兽送去墓地时，从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--幸運の笛吹き
function c68762510.initial_effect(c)
	aux.EnableDualAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68762510,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c68762510.con)
	e1:SetTarget(c68762510.tg)
	e1:SetOperation(c68762510.op)
	c:RegisterEffect(e1)
end
function c68762510.con(e,tp,eg,ep,ev,re,r,rp)
	if not aux.IsDualState(e) then return false end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE) and bc:IsType(TYPE_MONSTER)
end
function c68762510.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c68762510.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
