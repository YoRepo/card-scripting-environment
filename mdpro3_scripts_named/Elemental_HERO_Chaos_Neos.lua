--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 元素英雄 混沌新宇侠  (ID: 17032740)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level 9
-- ATK 3000 | DEF 2500
-- Setcode: 38668283912
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋「新空间侠·黑暗豹」＋「新空间侠·光辉青苔」
-- 把自己场上存在的上记的卡回到卡组的场合才能从融合卡组特殊召唤（不需要「融合」魔法卡）。结束阶段时这张卡回到融合卡组，场上存在的全部表侧表示怪兽变成盖放的状态。进行3次投掷硬币，进行表出现次数的以下处理
-- 。这个效果1回合只有1次在自己的主要阶段1才能使用。
-- ●3次：对方场上存在的全部怪兽破坏。
-- ●2次：这个回合对方场上表侧表示存在的效果怪兽全部效果无效化。
-- ●1次：自己场上存在的全部怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--E・HERO カオス・ネオス
function c17032740.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,89943723,43237273,17732278,false,false)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c17032740.splimit)
	c:RegisterEffect(e1)
	--return
	aux.EnableNeosReturn(c,c17032740.retop,c17032740.set_category)
	--coin
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(17032740,1))
	e5:SetCategory(CATEGORY_COIN+CATEGORY_DESTROY+CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c17032740.coincon)
	e5:SetTarget(c17032740.cointg)
	e5:SetOperation(c17032740.coinop)
	c:RegisterEffect(e5)
end
c17032740.material_setcode=0x8
function c17032740.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c17032740.set_category(e,tp,eg,ep,ev,re,r,rp)
	e:SetCategory(CATEGORY_MSET)
end
function c17032740.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	if c:IsLocation(LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
function c17032740.coincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c17032740.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c17032740.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	if c1+c2+c3==3 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif c1+c2+c3==2 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local c=e:GetHandler()
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
	elseif c1+c2+c3==1 then
		local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_MZONE,0,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
