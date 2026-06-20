--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 闪刀机关-多任务战刀机  (ID: 24010609)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 277
--
-- Effect Text:
-- ①：1回合1次，以这张卡以外的自己场上1张卡为对象才能发动。这个回合，对方不能对应自己的魔法卡的发动把魔法·陷阱·怪兽的效果发动。并且，再把作为对象的卡送去墓地。
-- ②：自己·对方的结束阶段才能发动。选最多有这个回合这张卡表侧表示存在期间自己发动的「闪刀」魔法卡数量的自己墓地的「闪刀」魔法卡在自己场上盖放（同名卡最多1张）。这个效果盖放的卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--閃刀機関－マルチロール
function c24010609.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24010609,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c24010609.tgtg)
	e2:SetOperation(c24010609.tgop)
	c:RegisterEffect(e2)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24010609,1))
	e3:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c24010609.settg)
	e3:SetOperation(c24010609.setop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c24010609.regop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_CHAIN_NEGATED)
	e5:SetOperation(c24010609.regop2)
	c:RegisterEffect(e5)
end
function c24010609.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc~=c end
	if chk==0 then return Duel.GetFlagEffect(tp,24010610)==0 and Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c24010609.tgop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(c24010609.actop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,24010610,RESET_PHASE+PHASE_END,0,1)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	Duel.BreakEffect()
	Duel.SendtoGrave(tc,REASON_EFFECT)
end
function c24010609.actop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) then
		Duel.SetChainLimit(c24010609.chainlm)
	end
end
function c24010609.chainlm(e,rp,tp)
	return tp==rp
end
function c24010609.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if re:GetHandler():IsSetCard(0x115) and re:IsActiveType(TYPE_SPELL) and rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local flag=c:GetFlagEffectLabel(24010609)
		if flag then
			c:SetFlagEffectLabel(24010609,flag+1)
		else
			c:RegisterFlagEffect(24010609,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,1)
		end
	end
end
function c24010609.regop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if re:GetHandler():IsSetCard(0x115) and re:IsActiveType(TYPE_SPELL) and rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local flag=c:GetFlagEffectLabel(24010609)
		if flag and flag>0 then
			c:SetFlagEffectLabel(24010609,flag-1)
		end
	end
end
function c24010609.setfilter(c)
	return c:IsSetCard(0x115) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c24010609.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetFlagEffectLabel(24010609)
	if chk==0 then return ct and ct>0 and Duel.IsExistingMatchingCard(c24010609.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,0)
end
function c24010609.gselect(g,ft)
	local fc=g:FilterCount(Card.IsType,nil,TYPE_FIELD)
	return fc<=1 and aux.dncheck(g) and #g-fc<=ft
end
function c24010609.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c24010609.setfilter),tp,LOCATION_GRAVE,0,nil)
	local ct=e:GetHandler():GetFlagEffectLabel(24010609) or 0
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if #g==0 or ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tg=g:SelectSubGroup(tp,c24010609.gselect,false,1,math.min(ct,ft+1),ft)
	if Duel.SSet(tp,tg)==0 then return end
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		tc:RegisterEffect(e1)
		tc=tg:GetNext()
	end
end
