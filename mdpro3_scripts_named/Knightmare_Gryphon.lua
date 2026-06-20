--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 梦幻崩影·狮鹫  (ID: 65330383)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Fiend
-- ATK 2500 | LINK
-- Setcode: 274
--
-- Effect Text:
-- 卡名不同的怪兽2只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤的场合，丢弃1张手卡，以自己墓地1张魔法·陷阱卡为对象才能发动。那张卡在自己场上盖放。这个效果盖放的卡在这个回合不能发动。这个效果的发动时这张卡是互相连接状态的场合，再让自己可以抽1
-- 张。
-- ②：只要这张卡在怪兽区域存在，双方不能把不在连接状态的特殊召唤的场上的怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--トロイメア・グリフォン
function c65330383.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c65330383.lcheck)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65330383,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,65330383)
	e1:SetCondition(c65330383.setcon)
	e1:SetCost(c65330383.setcost)
	e1:SetTarget(c65330383.settg)
	e1:SetOperation(c65330383.setop)
	c:RegisterEffect(e1)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c65330383.aclimit)
	c:RegisterEffect(e2)
end
function c65330383.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c65330383.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c65330383.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c65330383.setfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c65330383.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c65330383.setfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c65330383.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c65330383.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_DRAW+CATEGORY_SSET)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_SSET)
		e:SetLabel(0)
	end
end
function c65330383.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
		if e:GetLabel()==1 and Duel.IsPlayerCanDraw(tp,1)
			and Duel.SelectYesNo(tp,aux.Stringid(65330383,1)) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
function c65330383.aclimit(e,re,tp)
	local tc=re:GetHandler()
	return tc:IsLocation(LOCATION_MZONE) and tc:IsSummonType(SUMMON_TYPE_SPECIAL) and not tc:IsLinkState() and re:IsActiveType(TYPE_MONSTER)
end
