--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 索利德异虫  (ID: 3204467)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level 4
-- ATK 1000 | DEF 1600
-- Setcode: 62
--
-- Effect Text:
-- 这张卡的守备力上升自己墓地存在的名字带有「异虫」的爬虫类族怪兽数量×100的数值。这张卡被攻击，对方玩家受到战斗伤害的场合，那个伤害步骤结束时把对方场上存在的1张魔法或者陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ソリッド
function c3204467.initial_effect(c)
	--defup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c3204467.defval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCode(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c3204467.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3204467,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c3204467.descon)
	e3:SetTarget(c3204467.destg)
	e3:SetOperation(c3204467.desop)
	c:RegisterEffect(e3)
end
function c3204467.vfilter(c)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE)
end
function c3204467.defval(e,c)
	return Duel.GetMatchingGroupCount(c3204467.vfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
function c3204467.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c==Duel.GetAttackTarget() then
		c:RegisterFlagEffect(3204467,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
end
function c3204467.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(3204467) and aux.dsercon(e,tp,eg,ep,ev,re,r,rp)
end
function c3204467.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c3204467.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c3204467.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3204467.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c3204467.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
