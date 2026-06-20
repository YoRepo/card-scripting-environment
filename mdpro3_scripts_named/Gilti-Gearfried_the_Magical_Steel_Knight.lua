--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 钢铁魔导骑士-基尔提基亚·弗里德  (ID: 49161188)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 8
-- ATK 2700 | DEF 1600
-- Setcode: 110
--
-- Effect Text:
-- 属性不同的战士族怪兽×2
-- ①：1回合1次，这张卡为对象的魔法·陷阱·怪兽的效果发动时才能发动。那个效果无效，选场上1张卡破坏。
-- ②：只用场上的怪兽为素材作融合召唤的这张卡在同1次的战斗阶段中可以作2次攻击。
-- ③：1回合1次，这张卡和对方怪兽进行战斗的伤害计算时，从自己墓地把1张魔法卡除外才能发动。这张卡的攻击力直到回合结束时上升这张卡的守备力一半数值。
--[[ __CARD_HEADER_END__ ]]

--鋼鉄の魔導騎士－ギルティギア・フリード
function c49161188.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c49161188.ffilter,2,true)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49161188,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c49161188.discon)
	e1:SetTarget(c49161188.distg)
	e1:SetOperation(c49161188.disop)
	c:RegisterEffect(e1)
	--mat check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c49161188.matcheck)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(1)
	e3:SetLabelObject(e2)
	e3:SetCondition(c49161188.xacon)
	c:RegisterEffect(e3)
	--atk up
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(49161188,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c49161188.atkcon)
	e4:SetCost(c49161188.atkcost)
	e4:SetOperation(c49161188.atkop)
	c:RegisterEffect(e4)
end
function c49161188.ffilter(c,fc,sub,mg,sg)
	return c:IsRace(RACE_WARRIOR) and (not sg or not sg:IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
function c49161188.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(e:GetHandler()) and Duel.IsChainDisablable(ev)
end
function c49161188.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c49161188.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
function c49161188.matcheck(e,c)
	local g=c:GetMaterial()
	local res=true
	local tc=g:GetFirst()
	while tc do
		res=res and tc:IsLocation(LOCATION_MZONE)
		tc=g:GetNext()
	end
	if res then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
end
function c49161188.xacon(e)
	local flag=e:GetLabelObject():GetLabel()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION) and flag==1
end
function c49161188.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsControler(1-tp) and c:GetDefense()>0
end
function c49161188.atkfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost()
end
function c49161188.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49161188.atkfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c49161188.atkfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c49161188.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		e1:SetValue(c:GetDefense()/2)
		c:RegisterEffect(e1)
	end
end
