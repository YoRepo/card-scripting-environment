--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 布提斯  (ID: 75311421)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1700 | DEF 1900
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从自己卡组上面把3张卡翻开。那之中有怪兽的场合，可以通过把那之内的1只除外来把那1只同名怪兽从卡组以及翻开的卡之中加入手卡。剩下的卡回到卡组。
-- ②：通常召唤的这张卡被送去墓地的回合的结束阶段才能发动。从自己卡组上面把3张卡翻开，用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--ボティス
function c75311421.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c75311421.thtg)
	e1:SetOperation(c75311421.thop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(c75311421.regcon)
	e2:SetOperation(c75311421.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c75311421.seqcon)
	e3:SetTarget(c75311421.seqtg)
	e3:SetOperation(c75311421.seqop)
	c:RegisterEffect(e3)
end
function c75311421.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3 and Duel.IsPlayerCanRemove(tp) end
end
function c75311421.rmfilter(c,g)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() and g:IsExists(c75311421.thfilter,1,c,c:GetCode())
end
function c75311421.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c75311421.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	local dg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local sg=g:Filter(c75311421.rmfilter,nil,dg)
	if sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(75311421,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rc=sg:Select(tp,1,1,nil):GetFirst()
		Duel.Remove(rc,POS_FACEUP,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tc=dg:FilterSelect(tp,c75311421.thfilter,1,1,rc,rc:GetCode())
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
	Duel.ShuffleDeck(tp)
end
function c75311421.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_NORMAL)
end
function c75311421.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(75311421,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c75311421.seqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(75311421)>0
end
function c75311421.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c75311421.seqop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
