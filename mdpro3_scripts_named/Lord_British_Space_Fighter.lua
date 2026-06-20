--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 罗德不列颠号  (ID: 35514096)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 800
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽的场合，从下面效果选择1个发动。
-- ●只有1次可以继续攻击。
-- ●选择场上盖放的1张卡破坏。
-- ●在自己场上把1只「分机衍生物」（机械族·光·4星·攻/守1200）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ロードブリティッシュ
function c35514096.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35514096,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c35514096.condition)
	e1:SetTarget(c35514096.target)
	e1:SetOperation(c35514096.operation)
	c:RegisterEffect(e1)
end
function c35514096.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c35514096.filter(c)
	return c:IsFacedown()
end
function c35514096.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c35514096.filter(chkc) end
	if chk==0 then return true end
	local c=e:GetHandler()
	local t1=c:IsChainAttackable()
	local t2=Duel.IsExistingTarget(c35514096.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	local t3=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,35514097,0,TYPES_TOKEN_MONSTER,1200,1200,4,RACE_MACHINE,ATTRIBUTE_LIGHT)
	local op=0
	if t1 or t2 or t3 then
		local m={}
		local n={}
		local ct=1
		if t1 then m[ct]=aux.Stringid(35514096,1) n[ct]=1 ct=ct+1 end
		if t2 then m[ct]=aux.Stringid(35514096,2) n[ct]=2 ct=ct+1 end
		if t3 then m[ct]=aux.Stringid(35514096,3) n[ct]=3 ct=ct+1 end
		local sp=Duel.SelectOption(tp,table.unpack(m))
		op=n[sp+1]
	end
	e:SetLabel(op)
	if op==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,c35514096.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetCategory(CATEGORY_DESTROY)
	elseif op==3 then
		e:SetProperty(0)
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	else
		e:SetProperty(0)
		e:SetCategory(0)
	end
end
function c35514096.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==2 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	elseif e:GetLabel()==3 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,35514097,0,TYPES_TOKEN_MONSTER,1200,1200,4,RACE_MACHINE,ATTRIBUTE_LIGHT) then return end
		local token=Duel.CreateToken(tp,35514097)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	elseif e:GetLabel()==1 then
		if c:IsRelateToBattle() then
			Duel.ChainAttack()
		end
	end
end
