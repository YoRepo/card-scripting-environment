--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: No.99 希望皇 霍普德拉戈纳  (ID: 95134948)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 12
-- ATK 3000 | DEF 3000
-- Setcode: 276766792
--
-- Effect Text:
-- 12星怪兽×3只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方回合，把这张卡2个超量素材取除才能发动（这个效果发动的回合，自己不是超量怪兽不能从额外卡组特殊召唤，其他的自己怪兽不能直接攻击）。把1只「No.1」～「No.100」其中任意种的「No.
-- 」怪兽当作超量召唤从额外卡组特殊召唤。
-- ②：对方怪兽的攻击宣言时才能发动。那只对方怪兽的攻击力变成0。
--[[ __CARD_HEADER_END__ ]]

--No.99 希望皇ホープドラグナー
function c95134948.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,3,nil,nil,99)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95134948,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,95134948)
	e1:SetCost(c95134948.spcost)
	e1:SetTarget(c95134948.sptg)
	e1:SetOperation(c95134948.spop)
	c:RegisterEffect(e1)
	--loses ATK
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95134948,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1,95134949)
	e2:SetCondition(c95134948.atkcon)
	e2:SetOperation(c95134948.atkop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(95134948,ACTIVITY_SPSUMMON,c95134948.counterfilter)
	if not c95134948.global_check then
		c95134948.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c95134948.dacheck)
		Duel.RegisterEffect(ge1,0)
	end
end
aux.xyz_number[95134948]=99
function c95134948.counterfilter(c)
	return not c:IsSummonLocation(LOCATION_EXTRA) or c:IsType(TYPE_XYZ)
end
function c95134948.dacheck(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p=tc:GetControler()
	if Duel.GetAttackTarget()~=nil then return end
	if tc:GetFlagEffect(95134948)==0 then
		tc:RegisterFlagEffect(95134948,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		if Duel.GetFlagEffect(p,95134948)==0 then
			Duel.RegisterFlagEffect(p,95134948,RESET_PHASE+PHASE_END,0,1)
		else
			Duel.RegisterFlagEffect(p,95134949,RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c95134948.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,2,REASON_COST)
		and Duel.GetCustomActivityCount(95134948,tp,ACTIVITY_SPSUMMON)==0
		and Duel.GetFlagEffect(tp,95134949)==0
		and (Duel.GetFlagEffect(tp,95134948)==0 or c:GetFlagEffect(95134948)~=0) end
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c95134948.splimit)
	Duel.RegisterEffect(e1,tp)
	--cannot attack directly
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c95134948.ftarget)
	e2:SetLabel(c:GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	c:RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c95134948.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end
function c95134948.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c95134948.spfilter(c,e,tp)
	local no=aux.GetXyzNumber(c)
	return no and no>=1 and no<=100 and c:IsSetCard(0x48)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c95134948.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c95134948.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c95134948.spop(e,tp,eg,ep,ev,re,r,rp)
	if not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c95134948.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc then
		tc:SetMaterial(nil)
		if Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)>0 then
			tc:CompleteProcedure()
		end
	end
end
function c95134948.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and aux.nzatk(Duel.GetAttacker())
end
function c95134948.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
