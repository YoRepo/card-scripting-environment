--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 转生炎兽的愤怒  (ID: 14934922)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以从以下效果选择1个发动。
-- ●从手卡以及自己场上的表侧表示怪兽之中把1只「转生炎兽」怪兽送去墓地，以场上1张卡为对象才能发动。那张卡破坏。
-- ●以用和自身同名的怪兽为素材作连接召唤的自己场上1只「转生炎兽」连接怪兽为对象才能发动。选最多有那只怪兽的连接标记数量的对方场上的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--サラマングレイト・レイジ
function c14934922.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,14934922+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c14934922.target)
	e1:SetOperation(c14934922.activate)
	c:RegisterEffect(e1)
	if not c14934922.global_check then
		c14934922.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		ge1:SetCode(EFFECT_MATERIAL_CHECK)
		ge1:SetValue(c14934922.valcheck)
		Duel.RegisterEffect(ge1,0)
	end
end
function c14934922.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsLinkCode,1,nil,c:GetCode()) then
		c:RegisterFlagEffect(14934922,RESET_EVENT+0x4fe0000,0,1)
	end
end
function c14934922.costfilter(c,mc,tp)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,Group.FromCards(c,mc))
end
function c14934922.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x119) and c:IsSummonType(SUMMON_TYPE_LINK) and c:GetFlagEffect(14934922)~=0
end
function c14934922.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetLabel()==0 and chkc:IsOnField() and chkc~=e:GetHandler()
		or e:GetLabel()==1 and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c14934922.filter(chkc) end
	local b1=Duel.IsExistingMatchingCard(c14934922.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e:GetHandler(),tp)
	local b2=Duel.IsExistingTarget(c14934922.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(14934922,0),aux.Stringid(14934922,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(14934922,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(14934922,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c14934922.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e:GetHandler(),tp)
		Duel.SendtoGrave(g,REASON_COST)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c14934922.filter,tp,LOCATION_MZONE,0,1,1,nil)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c14934922.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	else
		local tc=Duel.GetFirstTarget()
		if not tc:IsRelateToEffect(e) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,tc:GetLink(),nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
