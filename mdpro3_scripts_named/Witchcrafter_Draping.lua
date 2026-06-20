--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 魔女术的裁剪  (ID: 56894757)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：以最多有自己场上的「魔女术」怪兽数量的对方场上的魔法·陷阱卡为对象才能发动。那些卡回到持有者手卡。
-- ②：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・ドレーピング
function c56894757.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,56894757)
	e1:SetTarget(c56894757.target)
	e1:SetOperation(c56894757.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56894757,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,56894757)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c56894757.thcon)
	e2:SetTarget(c56894757.thtg)
	e2:SetOperation(c56894757.thop)
	c:RegisterEffect(e2)
end
function c56894757.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c56894757.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c56894757.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,exc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() and c56894757.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c56894757.cfilter,tp,LOCATION_MZONE,0,1,exc)
		and Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_SZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c56894757.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_SZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c56894757.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c56894757.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c56894757.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c56894757.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c56894757.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c56894757.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
