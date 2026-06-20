--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 女巫特露德  (ID: 46294982)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 2600 | DEF 2100
--
-- Effect Text:
-- ①：场地区域有「急流山的金宫」存在的场合，这张卡可以不用解放作召唤。
-- ②：1回合1次，场地区域有「急流山的金宫」存在的场合，以场上1张卡为对象才能发动。那张卡破坏，这个回合，这张卡在同1次的战斗阶段中最多2次可以向怪兽攻击。
-- ③：这张卡战斗破坏对方怪兽时，以自己场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--ヘクサ・トルーデ
function c46294982.initial_effect(c)
	aux.AddCodeList(c,72283691)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46294982,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c46294982.ntcon)
	c:RegisterEffect(e1)
	--destroy and multi attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46294982,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c46294982.descon)
	e2:SetTarget(c46294982.destg)
	e2:SetOperation(c46294982.desop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(46294982,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c46294982.atktg)
	e3:SetOperation(c46294982.atkop)
	c:RegisterEffect(e3)
end
function c46294982.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.IsEnvironment(72283691,PLAYER_ALL,LOCATION_FZONE)
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c46294982.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(72283691,PLAYER_ALL,LOCATION_FZONE)
end
function c46294982.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c46294982.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c46294982.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsFaceup() and chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c46294982.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
