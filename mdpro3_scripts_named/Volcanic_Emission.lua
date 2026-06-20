--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 火山喷出  (ID: 58143766)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 50
--
-- Effect Text:
-- ①：可以从以下效果选择1个发动（这个卡名的以下效果1回合各能选择1次）。
-- ●从卡组选1只「火山」怪兽加入手卡或无视召唤条件特殊召唤。这个效果特殊召唤的怪兽在结束阶段回到手卡。
-- ●以场上1只炎族怪兽为对象才能发动。给与对方那只怪兽的原本攻击力数值的伤害。以自己场上的怪兽为对象发动的场合，这个效果给与的伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--ヴォルカニック・エミッション
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x32) and (c:IsAbleToHand()
		or Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,true,false))
end
function s.dfilter(c,tp)
	if c:IsControler(tp) and c:GetBaseAttack()<2 then return false end
	return c:IsFaceup() and c:GetBaseAttack()>0 and c:IsRace(RACE_PYRO)
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.dfilter(chkc,tp) end
	local b1=(Duel.GetFlagEffect(tp,id)==0 or not e:IsCostChecked())
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
	local b2=(Duel.GetFlagEffect(tp,id+o)==0 or not e:IsCostChecked())
		and Duel.IsExistingTarget(s.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp)
	if chk==0 then return b1 or b2 end
	local op=aux.SelectFromOptions(tp,{b1,aux.Stringid(id,0)},{b2,aux.Stringid(id,1)})
	e:SetLabel(op)
	if op==1 then
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
			e:SetProperty(0)
			Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
		end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	else
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_DAMAGE)
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			Duel.RegisterFlagEffect(tp,id+o,RESET_PHASE+PHASE_END,0,1)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local tc=Duel.SelectTarget(tp,s.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp):GetFirst()
		local atk=tc:GetBaseAttack()
		if tc:IsControler(tp) then atk=atk//2 end
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
	end
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==1 then
		s.sop(e,tp,eg,ep,ev,re,r,rp)
	elseif op==2 then
		s.dop(e,tp,eg,ep,ev,re,r,rp)
	end
end
function s.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local tc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if not tc then return end
	local b1=tc:IsAbleToHand()
	local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,true,false)
	local op=aux.SelectFromOptions(tp,{b1,1190},{b2,1152})
	if op==1 then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	elseif Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetOperation(s.ret)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
function s.ret(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
end
function s.dop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local d=1
		if tc:IsControler(tp) then d=2 end
		Duel.Damage(1-tp,tc:GetBaseAttack()//d,REASON_EFFECT)
	end
end
