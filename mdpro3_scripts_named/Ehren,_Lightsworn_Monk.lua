--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 光道武僧 艾琳  (ID: 44178886)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1000
-- Setcode: 56
--
-- Effect Text:
-- ①：这张卡向守备表示怪兽攻击的伤害计算前发动。那只怪兽回到持有者卡组。
-- ②：自己结束阶段发动。从自己卡组上面把3张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ライトロード・モンク エイリン
function c44178886.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44178886,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetTarget(c44178886.targ)
	e1:SetOperation(c44178886.op)
	c:RegisterEffect(e1)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetDescription(aux.Stringid(44178886,1))
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c44178886.discon)
	e2:SetTarget(c44178886.distg)
	e2:SetOperation(c44178886.disop)
	c:RegisterEffect(e2)
end
function c44178886.targ(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler() and t~=nil and not t:IsAttackPos() and t:IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,t,1,0,0)
end
function c44178886.op(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetAttackTarget()
	if t~=nil and t:IsRelateToBattle() and not t:IsAttackPos() then
		Duel.SendtoDeck(t,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c44178886.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c44178886.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c44178886.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
