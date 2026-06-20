--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 双天拳之熊罴  (ID: 85360035)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1000
-- Setcode: 335
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只「双天」怪兽为对象才能发动。那只怪兽破坏，从卡组把1张「双天」魔法卡加入手卡。
-- ②：这张卡在墓地存在的状态，效果怪兽为素材作融合召唤的自己场上的表侧表示的「双天」融合怪兽被战斗或者对方的效果破坏的场合才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--双天拳の熊羆
function c85360035.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85360035,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,85360035)
	e1:SetTarget(c85360035.target)
	e1:SetOperation(c85360035.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85360035,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CUSTOM+85360035)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,85360036)
	e2:SetTarget(c85360035.thtg)
	e2:SetOperation(c85360035.thop)
	c:RegisterEffect(e2)
	if not c85360035.global_check then
		c85360035.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_LEAVE_FIELD_P)
		ge1:SetCondition(c85360035.regcon)
		ge1:SetOperation(c85360035.regop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c85360035.cfilter(c,tp)
	return c:GetFlagEffect(85360035)~=0 and c:IsReason(REASON_DESTROY)
		and c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x14f) and c:IsType(TYPE_FUSION)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c85360035.regcon(e,tp,eg,ep,ev,re,r,rp)
	local v=0
	if eg:IsExists(c85360035.cfilter,1,nil,0) then v=v+1 end
	if eg:IsExists(c85360035.cfilter,1,nil,1) then v=v+2 end
	if v==0 then return false end
	e:SetLabel(({0,1,PLAYER_ALL})[v])
	return true
end
function c85360035.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(eg,EVENT_CUSTOM+85360035,re,r,rp,ep,e:GetLabel())
end
function c85360035.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x14f)
end
function c85360035.thfilter(c)
	return c:IsSetCard(0x14f) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c85360035.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c85360035.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c85360035.desfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c85360035.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c85360035.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c85360035.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c85360035.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c85360035.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
end
function c85360035.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
