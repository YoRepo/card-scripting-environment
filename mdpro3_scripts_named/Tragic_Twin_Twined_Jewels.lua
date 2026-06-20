--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 残丝断魂双玉绪  (ID: 81143465)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从额外卡组特殊召唤的自己场上的怪兽才能装备。
-- ①：比装备怪兽攻击力高的怪兽由对方从额外卡组特殊召唤的场合，以那之内的1只为对象才能发动。那只怪兽以及装备怪兽破坏，自己受到破坏的怪兽的原本攻击力合计数值的伤害。那之后，给与对方为和自己受到的伤害相同
-- 数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--あないみじや玉の緒ふたつ
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(s.eqlimit)
	c:RegisterEffect(e2)
	--destroy
	local custom_code=aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,EVENT_SPSUMMON_SUCCESS)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(custom_code)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCondition(s.descon)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
function s.eqlimit(e,c)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsControler(e:GetHandlerPlayer())
end
function s.eqfilter(c,tp)
	return c:IsFaceup() and c:IsSummonLocation(LOCATION_EXTRA)
		and c:IsControler(tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.eqfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,s.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToChain() and tc:IsRelateToChain() and tc:IsControler(tp) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function s.desfilter(c,tp,e,ec)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsLocation(LOCATION_MZONE) and c:IsSummonPlayer(1-tp) and c:IsCanBeEffectTarget(e) and c:IsFaceup()
		and c:IsAttackAbove(ec:GetAttack()+1)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and eg:IsExists(s.desfilter,1,nil,tp,e,ec)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local g=eg:Filter(s.desfilter,nil,tp,e,ec)
	if chkc then return g:IsContains(chkc) end
	if chk==0 then return #g>0 end
	local sg
	if g:GetCount()==1 then
		sg=g:Clone()
		Duel.SetTargetCard(sg)
	else
		Duel.Hint(HINTMSG_DESTROY,tp,HINTMSG_DESTROY)
		sg=Duel.SelectTarget(tp,aux.IsInGroup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,g)
	end
	local dg=sg:Clone()
	dg:AddCard(ec)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,2,0,0)
	if sg:GetFirst():IsFaceup() and math.max(0,sg:GetFirst():GetTextAttack())>0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
	end
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local tc=Duel.GetFirstTarget()
	local g=Group.FromCards(ec,tc)
	if tc:IsRelateToChain() and tc:IsType(TYPE_MONSTER) and Duel.Destroy(g,REASON_EFFECT)~=0 then
		local sg=Duel.GetOperatedGroup()
		local atk=0
		for dc in aux.Next(sg) do
			atk=atk+math.max(0,dc:GetTextAttack())
		end
		if atk>0 then
			local val=Duel.Damage(tp,atk,REASON_EFFECT)
			if val>0 and Duel.GetLP(tp)>0 then
				Duel.BreakEffect()
				Duel.Damage(1-tp,val,REASON_EFFECT)
			end
		end
	end
end
