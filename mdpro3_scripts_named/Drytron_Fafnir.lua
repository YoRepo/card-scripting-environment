--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 龙辉巧-扶筐增二  (ID: 58793369)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把「龙辉巧-扶筐增二」以外的1张「龙辉巧」魔法·陷阱卡加入手卡。
-- ②：仪式魔法卡的效果的发动以及那些发动的效果不会被无效化。
-- ③：1回合1次，自己场上有「龙辉巧」怪兽存在的状态，怪兽表侧表示召唤·特殊召唤的场合才能发动。这个回合，那些表侧表示怪兽的等级下降那攻击力每1000为1星的数值（最少到1星）。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ファフニール
function c58793369.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,58793369+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c58793369.activate)
	c:RegisterEffect(e1)
	--inactivatable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_INACTIVATE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetValue(c58793369.effectfilter)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISEFFECT)
	e3:SetRange(LOCATION_FZONE)
	e3:SetValue(c58793369.effectfilter)
	c:RegisterEffect(e3)
	--level down
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(58793369,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCondition(c58793369.lvcon)
	e4:SetTarget(c58793369.lvtg)
	e4:SetOperation(c58793369.lvop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
function c58793369.thfilter(c)
	return c:IsSetCard(0x154) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(58793369) and c:IsAbleToHand()
end
function c58793369.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58793369.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(58793369,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c58793369.effectfilter(e,ct)
	local etype=Duel.GetChainInfo(ct,CHAININFO_EXTTYPE)
	return etype&(TYPE_RITUAL+TYPE_SPELL)==TYPE_RITUAL+TYPE_SPELL
end
function c58793369.confilter(c)
	return c:IsFaceup() and c:IsSetCard(0x154)
end
function c58793369.lvfilter(c,e)
	return c:IsFaceup() and c:IsLevelAbove(2) and c:IsAttackAbove(1000) and (not e or c:IsRelateToEffect(e))
end
function c58793369.lvcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58793369.confilter,tp,LOCATION_MZONE,0,nil)
	return eg:IsExists(c58793369.lvfilter,1,nil,nil) and #g-eg:Filter(c58793369.confilter,nil):FilterCount(Card.IsControler,nil,tp)>0
end
function c58793369.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end
function c58793369.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c58793369.lvfilter,nil,e)
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		local lv=math.floor(atk/1000)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
